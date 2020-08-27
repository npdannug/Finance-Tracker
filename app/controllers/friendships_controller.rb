class FriendshipsController < ApplicationController
	def create				
    	current_user.friendships.build(friend_id: params[:friend])
		if current_user.save
			flash[:success] = "Following friend."
		else
			flash[:danger] = "Something went wrong. Please try again."
		end
		redirect_to my_friends_path
	end

	def destroy 
		friendship = current_user.friendships.where(friend_id: params[:id]).first
		friendship.destroy
		flash[:info] = "Stopped following."
		redirect_to my_friends_path
	end
end 