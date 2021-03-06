class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_var

  # ログイン後のリダイレクト先を定義
  def after_sign_in_path_for(_resource)
    root_path
  end

  private

  # 非ログインユーザーが、ログイン必須なアクセスをした場合の処理
  def sign_in_required
    redirect_to(introduction_path) unless user_signed_in?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:username])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: [:username])
  end

  def set_var
    @bootstrap_class_list = BOOTSTRAP_CLASS_LIST.deep_dup
    return unless user_signed_in?

    @player = current_user.player
    @current_job = @player.current_job
  end

  BOOTSTRAP_CLASS_LIST = {
    page_title:           'h4 mb-5',
    link_list:            '',
    link_list_btn:        'btn btn-secondary mb-3',
    link_list_btn_block:  'btn btn-light btn-block mb-3',
    link_list_text:       'small mb-2',
    link_btn_secondary:   'btn btn-secondary mb-3',
    link_btn_block:       'btn btn-primary btn-block mb-5',
    link_btn_block_light: 'btn btn-light btn-block mb-5',
    status_badge:         'badge badge-secondary badge-sm col-4 mr-2',
    job_badge:            'badge badge-light badge-pill',
    new_badge:            'badge badge-primary badge-sm',
    form:                 'my-5',
    form_group:           'form-group mb-3',
    form_field:           'form-control',
    form_submit:          'btn btn-block btn-primary font-weight-bold my-4 py-4',
    form_submit_small:    'btn btn-light font-weight-bold',
    form_small_text:      'form-text small text-gray',
    form_errors:          'mb-5',
    form_errors_title:    'h5',
    form_errors_lists:    'list-group',
    form_errors_list:     'list-group-item list-group-item-dark py-1'
  }.freeze
end
