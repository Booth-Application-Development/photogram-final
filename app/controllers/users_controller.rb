class UsersController < ApplicationController
 

    def index
      the_id = session[:user_id]
     @current_user = User.where({ :id => the_id }).first
      matching_users = User.all
      @list_of_users = matching_users.order({ :username => :asc })
      render({ :template => "user_templates/index.html.erb"})
    end
  
    def show
      the_id = session[:user_id]
          @current_user = User.where({ :id => the_id }).first
        @url_username = params.fetch("path_username")
        @matching_usernames = User.where({ :username => @url_username })
        @the_user = @matching_usernames.first
        render({ :template => "user_templates/show.html.erb"})
  


        
    end
  
  
  def authenticate
    un = params.fetch("input_username")
    pw = params.fetch("input_password")

    user = User.where({ :username => un }).at(0)

    if user.nil?
      redirect_to("/user_sign_in", :alert => "No one by that name around here")
    else
      if user.authenticate(pw)
        redirect_to("/", :notice => "Welcome back, " + user.username)
      else
        redirect_to("/user_sign_in", :alert => "Nice try, sucker!")
      end
    end
  end



  def toast_cookies
      reset_session

      redirect_to("/", { :notice => "See ya later!"})
  end

  def new_registration_form
    render({ :template => "users/signup_form.html.erb"})
  end

  def new_session_form
    render({ :template => "users/signin_form.html.erb"})
  end

 
 
  def index
    @users = User.all.order({ :username => :asc })

    render({ :template => "users/index.html" })
  end

  def show
    the_username = params.fetch("the_username")
    @user = User.where({ :username => the_username }).at(0)
    if @user.nil?
      redirect_to "/", notice: "User not found"
      return
    end
    render template: "users/show.html.erb"
  end

  def create
    user = User.new

    user.username = params.fetch("input_username")
    user.password = params.fetch("input_password")
    user.password_confirmation = params.fetch("input_password_confirmation")

    save_status = user.save
    
    if save_status == true
      session.store(:user_id, user.id)
    redirect_to("/users/#{user.username}", { :notice => "Welcome, " + user.username + "!"})
    else
    redirect_to("/user_sign_up", { :alert => user.errors.full_messages })
    end



  end

  def update
    the_id = params.fetch("modify_user")
    matching_users = User.where({ :id => the_id})
    the_user = matching_users.at(0)
    input_username = params.fetch("query_username")
    the_user.username = input_username
    the_user.save
    redirect_to("/users/" + the_user.username)
  end


  def destroy
    username = params.fetch("the_username")
    user = User.where({ :username => username }).at(0)

    user.destroy

    redirect_to("/users")
  end

end
