class UsersController < ApplicationController
  def my_portfolio
  	@tracked_stocks = current_user.stocks
  end

  def my_friends
  	@friends = current_user.friends
  end

  def search_friend  	
  	if params[:friend].present?
  	  @friends = User.search(params[:friend])
  	  @friends = current_user.except_current_user(@friends)
  	  if !@friends.empty?
	  	respond_to do |format|

	  	  format.js { render partial: "users/friend_result" }
	  	end
  	  else
  	  	respond_to do |format|
  	  	flash.now[:danger] = "No results found. Please try different keywords."
	  	  format.js { render partial: "users/friend_result" }
	  	end
  	  end
  	else
  	  respond_to do |format|
  	  	flash.now[:danger] = "Please enter name or email to search."
  	  	format.js { render partial: "users/friend_result" }
  	  end
  	end
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

end
