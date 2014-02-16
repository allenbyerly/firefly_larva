class UserController < ApplicationController
  def index
    @user=User.find(:all)
  end

  def edit
    index
  end

  def info

  end

  def medical

  end

  def results

  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(provider_params)
        format.html { redirect_to root_path, notice: 'Provider was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

end
