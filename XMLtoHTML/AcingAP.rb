module AcingAP
#common routines used and refactored in this module

  # open_head outputs <html><head>... Does not close the head tag
  def self.open_head
    puts %{
      <!DOCTYPE html>
      <html>
        <head>
        <title>Acing AP Human Geography</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/themes/default/jquery.mobile-1.1.0.min.css" />
        <script src="js/jquery-1.7.1.min.js"></script>
        <script src="js/jquery.mobile-1.1.0.min.js"></script>
	<script src="js/jquery.touchSwipe-1.2.6.js"></script>
    }
  end

  # outputs the floating footer. If passed true, Review button has data-theme=c else LaarnIt has that theme.
  def self.footer flag=false
    puts %{
      </div>
      <div data-role="footer" data-position="fixed" data-id="mainFooter">
        <div data-role="navbar" data-iconpos="top">
          <ul>
    }
    if !flag
      puts '<li><a href="learn.html" data-ajax="false" data-icon="grid" data-theme="c">Learn it!</a></li>'
      puts '<li><a href="review.html" data-ajax="false" data-icon="star">Review it!</a></li>'
    else
      puts '<li><a href="learn.html" data-ajax="false" data-icon="grid">Learn it!</a></li>'
      puts '<li><a href="review.html" data-ajax="false" data-icon="star" data-theme="c">Review it!</a></li>'
    end
    puts %{
            <li><a href="take.html" data-ajax="false" data-icon="check">Take it!</a></li>
          </ul>
        </div>
      </div>
    </div>
    }
  end
end