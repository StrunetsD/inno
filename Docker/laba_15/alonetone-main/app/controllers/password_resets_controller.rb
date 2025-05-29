class PasswordResetsController < ApplicationController
  before_action :load_user_using_perishable_token, only: %i[edit update]

  def edit
    @newly_invited_user = !@user.last_login_at?
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user.present?
      @user.reset_perishable_token!
      UserNotification.forgot_password(@user).deliver_now
      flash[:notice] = "Check your email and click the link to reset your password!"
      redirect_to login_path
    else
      flash[:error] = "Uhm. Uh oh. No user was found with that email address, maybe it was a different email?"
      redirect_to login_path
    end
  end

  def update
    @newly_invited_user = @user.never_activated?
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      @user.clear_token!
      @user.update_account_request! if @newly_invited_user
      UserSession.create(@user, true)
      flash[:notice] = "Phew, we were worried about you. Welcome back." unless @newly_invited_user
      redirect_to @newly_invited_user ? upload_path : user_home_path(@user.login)
    else
      render 'edit'
    end
  end

  private

  def load_user_using_perishable_token
    @user = User.where(perishable_token: params[:id]).first
    unless @user.present?
      flash[:error] = "Hmmm...that didn't work. If you still have issues, email #{Rails.configuration.alonetone.email}"
      redirect_to login_path
    end
    true
  end
end
