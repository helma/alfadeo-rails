require File.dirname(__FILE__) + '/../test_helper'
require 'tracklist_controller'

# Re-raise errors caught by the controller.
class TracklistController; def rescue_action(e) raise e end; end

class TracklistControllerTest < Test::Unit::TestCase
  def setup
    @controller = TracklistController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
