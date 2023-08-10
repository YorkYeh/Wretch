class ArticlesController < ApplicationController

    before_action :set_article, only: [:show] 
    before_action :set_user_article, only: [:edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show, :unlock] 
    
    def index
        #eager loading
        keyword = params[:keyword]
        @articles =  Article.search(keyword).order(id: :desc)
    end
        #如果不設定的話的話會是 
        #@articles = Article.all.order(id: :ase) 是升冪排序
        #降冪排序

    
    def show
        @comment = Comment.new
        @comments = @article.comments.order(id: :desc)
    end
        #只能放id，若找不到會噴錯
        # Article.find_by 
        #可以找不同欄位，找不到會nil，但如果是find_by!會噴錯
        #找單一系列用這個
        
        # Article.where 
        #與find_by相似，但找到的資料會被震列包起來，如果找不到會給[]空陣列
        #找一群資料用where


    def new
        # @實體變數
        @article = Article.new
    end

    def create
        #寫入資料庫

        # @article =  Article.new(article_params)
        @article =  current_user.articles.new(article_params)

        if  @article.save
            redirect_to "/articles",notice: "文章新增成功"
        else
            flash[:notice] = "失敗"
            render :new
            #拿 new.html.erb

            # flash[:alert] = "文章新增失敗"
            # redirect_to "/articles"
        end
    end
        # #防止送出表單時夾帶其他值須加上 clean(Strong Paramenter 強參數)
        # clean_params = params.require(:article).permit(:title, :content)

        # article = Article.new(title:params[:cc][:title],   content:params[:cc][:content] )
        # article.save

        # cc = Article.new
        # cc.title = params[:cc][:title]
        # cc.content = params[:cc][:content]
        # cc.save

    def edit
        # set_article
    end

    def update
        # set_article

        if @article.update(article_params)
            redirect_to articles_path, notice:'更新成功'
        else
            render :edit
        end
    end

    def destroy
        # set_article
        @article.destroy
        redirect_to articles_path, notice: '刪除成功'
    end


    def unlock
        result = Article.exists?(id: params[:id], password: params[:article][:password])

        if result
            if session[:article].present?
                session[:article] << params[:id] if not session[:article].include?(params[:id])
            else
                session[:article] = [params[:id]]
            end
            redirect_to article_path(id: params[:id])
        else
            redirect_back_or_to root_path , notice: '密碼錯誤'
        end
    end

    private

    def article_params
      params.require(:article).permit(:title, :content,:sub_titles,:password,:category)
    end 

    def set_article
        @article = Article.find(params[:id]) 

        if @article.password.present?
            #if !session[:article].present? or !session[:article].include?(params[:id])
            if not can_read?(params[:id])
                redirect_to root_path
            end
        end
    end

    def can_read?(id)
        #session[:article].present? and session[:article].includes?(id)
        session[:article]&.include?(id)
    end

    def set_user_article
        @article = current_user.articles.find(params[:id]) 
    end

end
