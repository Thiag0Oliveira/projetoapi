module RequestSpecHelper

  def json_body

    @jason_body ||= JSON.parse(response.body,symbolize_names: true)

end  