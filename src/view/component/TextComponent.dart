part of ReverseText;

class TextComponent
{

  FormElement   textForm;
  InputElement  textInput;
  InputElement  textOutput;
  LabelElement  textOutputLabel;
  InputElement  checkbox;
  ButtonElement reverseButton;

  TextComponent()
  {
    // use HTML5 querySelector for DOM retrieval
    textForm         = querySelector('#textForm');
    textInput        = textForm.querySelector('#inputText');
    textOutput       = textForm.querySelector('#outputText');
    textOutputLabel  = textForm.querySelector('#outputTextLabel');
    checkbox         = textForm.querySelector('input[type=checkbox]');
    reverseButton    = textForm.querySelector('button[type=submit]');

    // listen to checkbox state changes
    checkbox.onChange.listen(handleEvent);

    // listen to reverse button clicks
    reverseButton.onClick.listen(handleEvent );

    // Listen for input
    textInput.onKeyUp.listen(handleEvent);
  }

  /**
   * Set the palindrome indicator
   */
  void set isPalindrome ( bool izzit )
  {
    if (izzit) {
      textOutputLabel.innerHtml = "Palindrome Detected";
    } else {
      textOutputLabel.innerHtml = "Output Text";
    }
  }

  /**
   * Set the ouput fields text value
   */
  void set outputText ( String value )
  {
    isPalindrome = false;
    textOutput.value = value;
  }

  /**
   * Get the input fields text value
   */
  String get inputText
  {
    return textInput.value;
  }

  /**
   * Handle DOM Events this component is interested in.
   */
  void handleEvent( Event event )
  {
    switch( event.type )
    {
      /*
       * A keypress has been detected. If 'Reverse as I type'
       * is checked, dispatch a text changed event
       */
      case 'keyup':
        if (checkbox.checked) dispatchTextChangedEvent();
        break;

      /*
       * The TextComponent's reverse button has been clicked.
       * Prevent the form from submitting, and dispatch a
       * text changed event
       */
      case 'click':
        event.preventDefault();
        dispatchTextChangedEvent();
        break;
    }
  }

  /**
   * Add EventListeners to TextComponent. TextComponent will
   * dispatch only AppEvent.INPUT_TEXT_CHANGED events, but
   * you can still listen to other events generated by its
   * DOM elements as they propagate through #textForm.
   *
   * There is no reason to implement a removeEventListener in
   * this demo, as we never unregister the TextComponentMediator.
   */
  void addEventListener( String type, EventListener listener )
  {
    // delegate to #textForm
    textForm.addEventListener(type, listener );
  }

  /**
   * Dispatch an event
   */
  void dispatchTextChangedEvent()
  {
    Event event = new Event.eventType("HTMLEvents", AppEvents.INPUT_TEXT_CHANGED, canBubble: true, cancelable: true);
    textForm.dispatchEvent( event );
  }
}