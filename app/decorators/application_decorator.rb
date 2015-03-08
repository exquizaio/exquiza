class ApplicationDecorator < Draper::Decorator
  delegate_all

  def session_actions
    h.unordered_list class: "user-profile-action-list site-header-box site-header-box--omega" do
      unless h.user_signed_in?
        h.content_tag :li, signin_button, class: "user-profile-action"
        h.content_tag :li, signup_button, class: "user-profile-action"
      else
        h.content_tag :li, signout_button, class: "user-profile-action"
      end
    end
  end

  def nav_actions
    puts h.user_signed_in?
    h.unordered_list class: "site-nav site-header-list site-header-box site-header-box--alpha" do
      [].tap do |b|
        b << h.content_tag(:li, questions_index_button, class: "site-nav-item") if h.user_signed_in? and h.current_user.admin?
        b << h.content_tag(:li, tests_index_button, class: "site-nav-item") if h.user_signed_in?
      end.join.html_safe
    end
  end

  def signin_button
    session_header_button_tag "Sign In", path: h.new_user_session_path, class: "session-button--signin"
  end

  def signout_button
    session_header_button_tag "Sign Out", path: h.destroy_user_session_path, class: "session-button--signout", method: :delete
  end

  def signup_button
    session_header_button_tag "Sign Up", path: h.new_user_registration_path, class: "session-button--signup"
  end

  def questions_index_button
    header_button_tag "Questions", path: h.questions_path
  end

  def tests_index_button
    header_button_tag "Tests", path: h.tests_path
  end

  def header_button_tag(text, path:, **options)
    h.link_to(text, path, class: "button header-button #{options.delete(:class)}", **options)
  end

  def session_header_button_tag(text, **options)
    header_button_tag(text, class: "session-button #{options.delete(:class)}", **options)
  end

end
