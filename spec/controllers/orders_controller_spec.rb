require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = User.create(email: "admin@ecommerce.com", password: "12345678", is_admin: true)
    sign_in :user, user
    @cart_id = Cart.create.id
    session[:cart_id] = @cart_id
  end


  let(:valid_attributes) {{
    customer: "Mr Test",
    shipping_address: "The Road of Test, Rails Way, 51",
    email: "test@website.com",
    phone: "777 777 777",
    total: 8957
  }}

  let(:invalid_attributes) {{
    shipping_address: "The Road of Test, Rails Way, 51",
    total: 8957
  }}


  let(:valid_session) { {id: 1, cart_id: @cart_id}  }


  describe "GET #show" do
    it "assigns the requested order as @order" do
      order = Order.create! valid_attributes
      get :show, {:id => order.to_param}, valid_session
      expect(assigns(:order)).to eq(order)
    end
  end

  describe "GET #new" do
    it "assigns a new order as @order" do
      get :new, {}, valid_session
      expect(assigns(:order)).to be_a_new(Order)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Order" do
        expect {
          post :create, {:order => valid_attributes}, valid_session
        }.to change(Order, :count).by(1)
      end

      it "assigns a newly created order as @order" do
        post :create, {:order => valid_attributes}, valid_session
        expect(assigns(:order)).to be_a(Order)
        expect(assigns(:order)).to be_persisted
      end

      it "redirects to the created order" do
        post :create, {:order => valid_attributes}, valid_session
        expect(response).to redirect_to(Order.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved order as @order" do
        post :create, {:order => invalid_attributes}, valid_session
        expect(assigns(:order)).to be_a_new(Order)
      end

      it "re-renders the 'new' template" do
        post :create, {:order => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end
end
