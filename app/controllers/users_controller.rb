class UsersController < ApplicationController
    before_action :find_user, only: [:edit, :show, :edit_subjects, :update_subjects, :edit_courses]
    def index 
        @users = User.all
    end

    def new 
        @user = User.new
    end

    def professors
        @professors = User.where(professor: "true")
        render :professors
    end

    def students
        @students = User.where(professor: "false")
        render :students
    end

    def create 
        @user = User.create(user_params)
        if @user.valid?
            @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    def edit 
        
    end

    def show 
        # @user = User.find(params[:id])
    end

    def logout
      
        session.delete :user_id
        redirect_to "/"
    end

    def edit_subjects
        if @current == nil
            redirect_to "/"
        end
    end

    def update_subjects
        # byebug
        @enroll = Enrollment.create(subject_id: params[:user][:subject_ids], student: @user)
        if @enroll.valid?
            @enroll.save
            redirect_to user_path(@user)
        else   
            render :edit_subjects
        end
        
    end


    def home
        
    end

    def edit_courses
        if @current == nil
            redirect_to "/"
        end
        @enroll = Enrollment.new
    end

    def update_courses
        byebug
        @enroll = Enrollment.cre
    end

    private

    def find_user
        @user = User.find(params[:id])
    end
    
    def id_params
        params.permit(:user_ids)
    end

    def user_params
        params.require(:user).permit(:name, :password, :email, :password_confirmation, :professor, :house_id, :subject_ids)
    end

end
