class SponsorsFragment < Android::App::Fragment
  def onCreateView(inflater, container, savedInstanceState)
    @view ||= begin
      createLogoView = lambda do |basename, url|
        logoView = Android::Widget::ImageView.new(activity)
        logoView.imageResource = activity.resources.getIdentifier(basename, 'drawable', activity.packageName)
        logoView.onClickListener = self
        logoView.tag = url
        logoView
      end

      layout = Android::Widget::LinearLayout.new(activity)
      layout.orientation = Android::Widget::LinearLayout::VERTICAL

      layout.addView(createLogoView.call('pixate', 'http://pixate.com'))

      layout2 = Android::Widget::LinearLayout.new(activity)
      layout2.orientation = Android::Widget::LinearLayout::HORIZONTAL
      layout2.gravity = Android::View::Gravity::CENTER_HORIZONTAL

      layout2.addView(createLogoView.call('terriblelabs', 'http://terriblelabs.com'))
      layout2.addView(createLogoView.call('rubymine', 'http://jetbrains.com/ruby'))

      layout.addView(layout2)

      scrollView = Android::Widget::ScrollView.new(activity)
      scrollView.backgroundColor = Android::Graphics::Color::WHITE
      scrollView.addView(layout)
      scrollView
    end
  end

  def onClick(view)
    # Open the sponsor's URL into the browser. If the user taps the back button, we will get back to our app.
    uri = Android::Net::Uri.parse(view.tag)
    browserIntent = Android::Content::Intent.new(Android::Content::Intent::ACTION_VIEW, uri)
    activity.startActivity(browserIntent)
  end
end
