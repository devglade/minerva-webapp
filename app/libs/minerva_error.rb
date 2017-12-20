class MinervaError < StandardError
  DEFAULT_MESSAGE = '에러가 발생했습니다.'
  def initialize(msg=nil)
    @message = msg || DEFAULT_MESSAGE
  end

  def message
    @message
  end
end