class UsersController < ApplicationController
  
  def my_portfolio
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