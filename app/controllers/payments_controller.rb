class PaymentsController < ApplicationController

    before_action :authenticate_user!
    
    include Solutionable

    def show
        price = solution_price(params[:id])
        redirect_to root_path,alter: '無此方案' and return if price.nil?

        @order = Order.new
    end

    # def solution_price(s)
    #     solutions = {pro: 10, premium: 50}
    #     solutions[s.to_sym]
    # end

end
