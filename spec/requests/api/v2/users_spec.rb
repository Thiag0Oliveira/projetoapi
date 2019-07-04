require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  
  let!(:user) {create(:user)}
  let!(:user_id) {user.id}
  let!(:auth_data) {user.create_new_auth_token}
  let(:headers) do
    {
      'Accept' => 'application/vnd.projetoapi.v2',
      'Content-Type'=> Mime[:json].to_s,
      'access-token' => auth_data['access-token'],
      'uid' => auth_data['uid'],
      'client' => auth_data['client']

    }
  end 
  before{ host! 'api.projetoapi.test'}

  #====================================================================================

  describe 'GET /auth/validate_token' do

   
    
    context 'when the request headers are valid' do

      before do
         get '/auth/validate_token',params:{},headers: headers
       end

      it 'returns the user' do
       # json_body = JSON.parse(response.body)
        expect(json_body[:data][:id].to_i).to eq(user_id)
      end

      it 'returns status 200' do
        expect(response).to have_http_status(200)
      end
    end

      context 'when the request headers are not valid'  do

        before do
          headers['access-token'] = 'invalid_token'
          get '/auth/validate_token',params:{},headers: headers
        end

        let(:user_id) {10000}

        it 'returns status code 401' do
          expect(response).to have_http_status(401)

        end  

      end  

  end

#=======================================================================================

  describe 'POST /auth' do
    before do
    #  headers = { 'Accept' => 'application/vnd.projetoapi.v1' }
      post '/auth', params: user_params.to_json, headers: headers
    end

    context 'when the request params are valid' do
      let(:user_params) { attributes_for(:user) }
      #byebug
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns json data for the created user' do
        #json_body = JSON.parse(response.body,symbolize_names: true)
        expect(json_body[:data][:email]).to eq(user_params[:email])
      end
    end

    context 'when the request params are invalid' do
      let(:user_params) { attributes_for(:user, email: 'invalid.email@') }

     it 'returns status code 422' do
       expect(response).to have_http_status(422)
     end

      it 'returns the json data for the errors' do
       # json_body = JSON.parse(response.body,symbolize_names: true)
        expect(json_body).to have_key(:errors)
      end
    end
  end

#========================================================================================

  describe 'PUT /auth' do
    before do
    #  headers = { 'Accept' => 'application/vnd.projetoapi.v1' }
      put '/auth', params: user_params.to_json, headers: headers
    end

    context 'when the request params are valid' do
      let(:user_params) { { email: 'new@projetoapi.com' } }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the json data for the updated user' do
      #  json_body = JSON.parse(response.body,symbolize_names: true)
        expect(json_body[:data][:email]).to eq(user_params[:email])
      end
    end

    context 'when the request params are invalid' do
      let(:user_params) { { email: 'invalid.email@' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns json data for the errors' do
       # json_body = JSON.parse(response.body,symbolize_names: true)
        expect(json_body).to have_key(:errors)
      end
    end
  end  

#========================================================================================

describe 'DELETE /auth' do
  before do
  #  headers = { "Accept" => "application/vnd.projetoapi.v1" }
    delete '/auth', params: {}, headers: headers
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(200)
  end

  it 'removes the user from database' do
    expect( User.find_by(id: user_id) ).to be_nil
  end
end

#==========================================================================================

end  