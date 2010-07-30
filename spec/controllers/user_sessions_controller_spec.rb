require 'spec_helper'

describe UserSessionsController do

  before(:each) do
    @user = Factory.create(:user)
    activate_authlogic
  end

  describe "GET new" do
    it "assigns a new session as @user_session" do
      @session = UserSession.new
      UserSession.stub!(:new).and_return(@session)
      get :new
      assigns[:user_session].should equal(@session)
    end

    it "should have access to the subdomain" do
      @session = UserSession.new
      UserSession.stub!(:new).and_return(@session)
      get :new
      assigns[:user_session].should equal(@session)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "logs the user in" do
        @session = UserSession.new
        UserSession.stub!(:new).and_return(@session)
        post :create, :user_session => {:these => 'params'}
        assigns[:user_session].should equal(@session)
      end

      it "redirects to the logged in user" do

        @session = UserSession.new
        @session.should_receive(:save).and_return(true)
        UserSession.stub!(:new).and_return(@session)
        post :create, :user_session => {:login => @user.email, :password => "password"}
        response.should redirect_to(account_path)
      end
    end

    describe "with invalid params" do
      before do
        @invalid_params = {:email => 'not_an_email'}
        @new_user = User.new
      end

      it "re-renders the 'new' template" do
        User.stub!(:new).and_return(@new_user)
        post :create, :user_session => @invalid_params
        response.should render_template('new')
      end
    end

  end

  describe "DELETE destroy" do
    before do
      #activate_authlogic
      @session = UserSession.create @user
      User.stub!(:find).and_return(@user)
    end

    it "destroys the requested session" do
      UserSession.should_receive(:find).and_return(@session)
      @session.should_receive(:destroy)
      delete :destroy
    end

    it "redirects to the login page" do
      User.stub!(:find).and_return(@user)
      delete :destroy, :id => "1"
      response.should redirect_to(new_user_session_url)
    end
  end

end