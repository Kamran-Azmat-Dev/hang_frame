class GetFrameDetails
  def call(product)
    Frame::FrameDetailsPresenter.new(product)
  end
end
