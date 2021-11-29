module Api
  module V1



    class UsersController < ApplicationController
      include UserHelper

      def index
        users = User.all
        render json: users, status: :ok
      end


      def update

        @user = User.find(params[:id])
        #check that user have enough money
        if @user.amount >= user_params[:amount].to_f
          #check that transaction was successfully
          if transaction_result?(amount: 100, destination: 2)
            new_amount = @user.amount - user_params[:amount].to_f
            @user.update(amount: new_amount)
            render json: @user, status: :ok
          end
        else
          render json: {error: 'Wrong amount'}, status: :bad_request
        end

      end

      private
      def user_params
        params.require(:params).permit(:amount, :destination)
      end

    end
  end
end