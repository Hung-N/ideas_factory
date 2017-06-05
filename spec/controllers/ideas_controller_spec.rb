require 'rails_helper'

RSpec.describe IdeasController, type: :controller do

  describe '#new' do

    context 'with NO user signed in' do
      it 'redirects to the sign in page' do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end

  end

  describe '#create' do
    context 'with NO user signed in' do
      it 'redirects to sign in page' do
        post :create
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

end
