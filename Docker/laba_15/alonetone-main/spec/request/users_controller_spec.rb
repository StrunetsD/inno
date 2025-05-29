require "rails_helper"

RSpec.describe UsersController, type: :request do
  before :each do
    create_user_session(users(:sudara))
  end

  context "GET show" do
    it "displays user info route v1" do
      get "/users/#{users(:sudara).login}"
      expect(response).to be_successful
    end

    it "displays user info route v2" do
      get "/#{users(:sudara).login}"
      expect(response).to be_successful
    end

    it "displays user info for all users" do
      User.find_each do |user|
        unless user.login.blank?
          get "/#{user.login}"
          expect(response).to be_successful
        end
      end
    end

    # it should display 5 unique titles for assets of latest listens
    it "displays only unique listens on Recently Listened To" do
      # create 5 of the same listen and one extra
      # ensure it definitely shows the other listens
      5.times do |t|
        Listen.create(asset: assets(:valid_arthur_mp3), listener: users(:sudara), track_owner: users(:arthur))
      end

      get "/#{users(:sudara).login}"

      # from assets(:valid_arthur_mp3)
      expect(response.body).to match(/arthur\/tracks\/song1.mp3/)
      # from listens(:another_valid_asset_to_test_on_latest)
      expect(response.body).to match(/Second hottest asset to test latest/)
      # from assets(:asset_with_relations_for_soft_delete)
      expect(response.body).to match(/Asset to test soft deletion of relations/)
    end
  end

  context "POST create" do
    let(:params) do
      {
        user: {
          login: 'quire',
          email: 'quire@example.com',
          password: 'quire12345',
          password_confirmation: 'quire12345'
        }
      }
    end
    context "if Akismet check returns not spam" do
      before do
        allow_any_instance_of(PreventAbuse).to receive(:is_a_bot?).and_return(false)
        akismet_stub_response_ham
      end

      it "should create a user" do
        expect {
          post "/users", params: params
        }.to change(User, :count).by(1)
      end

      it "should redirect" do
        post "/users", params: params

        expect(response.status).to eq(302)
        expect(response).to redirect_to(login_url(already_joined: true))
      end

      it "should raise an error if user is invalid" do
        post "/users", params: { user: { login: 'bar', password: 'foo' } }

        expect(flash[:error]).to be_present
        expect(response).to render_template("users/new")
      end
    end

    context "if Akismet check returns spam" do
      before do
        allow_any_instance_of(PreventAbuse).to receive(:is_a_bot?).and_return(false)
        akismet_stub_response_spam
      end

      it "should return an error message and logout" do
        post "/users", params: params

        expect(flash[:error]).to match (/magic fairies/)
        expect(response).to redirect_to(logout_path)
      end

      it "should not create a user" do
        expect {
          post "/users", params: params
        }.not_to change(User, :count)
      end

      it "should set the user to spam before soft deleting" do
        post "/users", params: params

        expect(User.with_deleted.where(login: params[:user][:login]).first.is_spam).to eq(true)
      end

      it "should mark that user request as soft_deleted" do
        post "/users", params: params

        expect(User.with_deleted.where(login: params[:user][:login]).first.deleted_at).not_to be_nil
      end

      context "invalid user" do
        before do
          params[:user].delete(:login)
        end

        it "should raise validation error if user's missing login before Akismet check" do
          post "/users", params: { user: params }
          expect(flash[:error]).to match(/that didn't quite work/)
        end

        it "should not create user if user is invalid" do
          expect do
            post "/users", params: { user: params }
          end.not_to change(User, :count)
        end
      end

      context "spam user" do
        it "should should set user as spam if Akismet check fails" do
          
          post "/users", params: { user: params }
          expect(flash[:error]).to match(/that didn't quite work/)
        end
      end
    end
  end
end
