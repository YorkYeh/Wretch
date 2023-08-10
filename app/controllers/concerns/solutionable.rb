module Solutionable

    def solution_price(s)
        solutions = {pro: 10, premium: 50}
        solutions[s.to_sym]
    end

end


# module M
#     extend ActiveSupport::Concern
      
#     included do
#       scope :disabled, -> { where(disabled: true) } 
#     end
#     class_methods do
#       ...
#     end
#   end