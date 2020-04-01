class UsersController < ApplicationController
  

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def my_portfolio
    @user = current_user
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @my_friends = current_user.friends 
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends  )
      if @friends
        respond_to do |format|
          format.js {render partial: 'friends/result'} #result.js in users view
        end
      else
          respond_to do |format| 
            flash.now[:alert] = "No friend found with Name: #{params[:friend]}"
            format.js {render partial: 'friends/result'}
          end  
      end
    else
        respond_to do |format| 
          flash.now[:alert] = 'Please enter a Name to search'
          format.js {render partial: 'friends/result'}
        end  
    end
  end

end