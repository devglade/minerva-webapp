class SubdomainRoutes
  def self.matches? request
    case request.subdomain
    when '', 'www'
      false
    else
      true
    end
  end
end