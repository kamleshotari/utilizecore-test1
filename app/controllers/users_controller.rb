class UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @user.build_address
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create_user
    @user = User.new(user_params)
    @user.password = "12345678" if current_user.is_admin?
    respond_to do |format|
      if @user.save
        UserMailer.with(user: @user, password: "12345678").welcome_mail.deliver_later
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :role, :password, :password_confirmation, address_attributes: [:address_line_one, :address_line_two,
                                                                       :city, :state, :country,
                                                                       :pincode, :mobile_number])
    end
end
