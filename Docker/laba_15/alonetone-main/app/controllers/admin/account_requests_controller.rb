module Admin
  class AccountRequestsController < Admin::BaseController
    before_action :set_account_request, except: %i[index]

    def index
      @pagy, @account_requests = pagy(AccountRequest.filter_by(params[:filter_by]))
    end

    def approve
      @user = @account_request.approve!(current_user)
      InviteNotification.approved_request(@user).deliver_now
      render plain: 'approved'
    end

    def deny
      @account_request.deny!(current_user)
      render plain: 'denied'
    end

    private

    def set_account_request
      @account_request = AccountRequest.find(params[:id])
    end
  end
end
