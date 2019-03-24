class ApiVersionConstraint
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(req)
    @default || req.headers['accept'].include?("application/vnd.projetoapi.v#{@version}")
  end 
end 
