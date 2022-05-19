class UsersController < ApplicationController

  def show
    @user  = User.all
    @prototypes =  @user.prototypes
  end
end
