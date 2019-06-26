# カリキュラム解答
require 'rails_helper'

describe MessagesController do
  let(:group) { create(:group) }
  let(:user) { create(:user) }

  describe 'Get #index' do

    context 'log in' do

      before do
        login user
        get :index, params: { group_id: group.id }
      end

      it 'assigns @chat_message' do
        expect(assigns(:chat_message)).to be_a_new(Message)
      end

      it 'assigns @group' do
        expect(assigns(:group)).to eq group
      end

      it 'redners index' do
        expect(response).to render_template :index
      end
    end

    context 'not log in' do
      before do
        get :index, params: { group_id: group.id }
      end

      it 'redirects to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'Post #create' do
      let(:message) { attributes_for(:message) }

      context 'log in' do

        before do
          login user
        end

        context 'save success' do

          it 'save success with message' do
            expect do
              post :create, params: {
                message: message,
                user_id: user.id,
                group_id: group.id
              }
            end.to change(Message, :count).by(1)
          end

          it 'redirects to group_messages_path' do
            post :create, params: {
                message: message,
                user_id: user.id,
                group_id: group.id
              }
            expect(response).to redirect_to(group_messages_path)
          end
        end

        context 'save failed' do
          let(:nil_message) { attributes_for(:message, body: nil, image: nil) }

          it "don't save message" do
            expect do
              post :create, params: {
                message: nil_message,
                user_id: user.id,
                group_id: group.id
              }
            end.to change(Message, :count).by(0)
          end

          it "renders :index" do
            post :create, params: {
              message: nil_message,
              user_id: user.id,
              group_id: group.id
            }
            expect(response).to render_template :index
          end
        end

      end

      context 'not login' do
        before do
          post :create, params: {
            message: message,
            user_id: user.id,
            group_id: group.id
          }
        end

        it 'redirects to new_user_session_path' do
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
  end
end

# my answer
# require 'rails_helper'

# describe MessagesController, type: :controller do

#   describe 'GET #index' do

#     describe 'After Login' do
#       login_user

#       it "assigns the requested group to @group" do
#         group = create(:group)
#         get :index, params: {group_id: group}
#         expect(assigns(:group)).to eq group
#       end

#       it "assigns the requested chat_messages to @chat_messages" do
#         group = create(:group)
#         chat_messages = create_list(:message, 3, group: group)
#         get :index, params: {group_id: group}
#         expect(assigns(:chat_messages)).to eq chat_messages
#       end

#       it "assigns the requested chat_message to @chat_message" do
#         group = create(:group)
#         chat_message = Message.new
#         get :index, params: {group_id: group}
#         expect(assigns(:chat_message)).to eq chat_message
#       end

#       it "renders the :index template" do
#         group = create(:group)
#         get :index, params: {group_id: group}
#         expect(response).to render_template :index
#       end

#     end

#     describe 'Before Login' do

#       it "renders the :devise/sessions#new template" do
#         group = create(:group)
#         get :index, params: {group_id: group}
#         expect(response).to render_template('devise/sessions/new')
#       end

#     end

#   end

# end

# カリキュラム解答 create
#   describe '#create' do
#     let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }

#     context 'log in' do
#       before do
#         login user
#       end

#       context 'can save' do
#         subject {
#           post :create,
#           params: params
#         }

#         it 'count up message' do
#           expect{ subject }.to change(Message, :count).by(1)
#         end

#         it 'redirects to group_messages_path' do
#           subject
#           expect(response).to redirect_to(group_messages_path(group))
#         end
#       end

#       context 'can not save' do
#         let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, content: nil, image: nil) } }

#         subject {
#           post :create,
#           params: invalid_params
#         }

#         it 'does not count up' do
#           expect{ subject }.not_to change(Message, :count)
#         end

#         it 'renders index' do
#           subject
#           expect(response).to render_template :index
#         end
#       end
#     end

#     context 'not log in' do

#       it 'redirects to new_user_session_path' do
#         post :create, params: params
#         expect(response).to redirect_to(new_user_session_path)
#       end
#     end
#   end
# end