class SchedulesController < ApplicationController
  def index
    @schedules = Schedule.all
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      flash[:notice] = 'スケジュールが作成されました。'
      redirect_to schedules_path
    else
      flash.now[:alert] = '必須項目に記入してください。'
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      flash[:notice] = 'スケジュールが更新されました。'
      redirect_to schedule_path(@schedule)
    else
      flash.now[:alert] = '必須項目に記入してください。'
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    flash[:notice] = 'スケジュールが削除されました。'
    redirect_to schedules_path, status: :see_other
  end

  private

  def schedule_params
    params.require(:schedule).permit(:title, :start_date, :end_date, :all_day, :schedule_memo)
  end
end

