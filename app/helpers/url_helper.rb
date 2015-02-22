module URLHelper
  def redirect_back_or_to(path:, **options)
    redirect_to(:back, **options)
  rescue ActionController::RedirectBackError
    redirect_to(path, **options)
  end
end
