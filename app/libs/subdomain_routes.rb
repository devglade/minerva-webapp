class SubdomainRoutes
  def self.matches? request
    case request.subdomain
    when '', 'www'
      true
    else
      false
    end
  end
end