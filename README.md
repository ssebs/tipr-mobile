# tipr_mobile

Tip calculator that gives you both the tip amount, and the total amount for the bill.

> Mobile version of https://github.com/ssebs/tipr
> Web version demo https://ssebs.github.io/tipr/

Android release: https://play.google.com/store/apps/details?id=com.ssebs.tipr_mobile&hl=en_US&gl=US

## features to add
- [x] Tip calculator
  - [x] enter bill amount
  - [x] enter tip %
  - [x] get total $
  - [x] get tip $
- [x] use numpad instead of text to enter
- ~~[x] use dropdown for tip %~~
- [x] 3 boxes for tip options (like the memes)
  - 15, 18, custom
- [ ] "flush" round number mode
  - total amount rounds up by 5's.
  - e.g. bill of $62.52, tip of ~15-18%, total ends up being $75
    - enter bill
    - enter "suggested" tip percentage
    - calc tip amount
      - `bill * tip percentage`
    - calc total amount
      - `tip amount + bill`
      - round total to nearest 5
        - `new total`
      - "new total" - `total amount`
        - update tip amount to this
        - calc tip percentage from tip amount

### wish
- add home screen widget
- add support for wearos
- export to iOS

## docs:
- form
  - https://api.flutter.dev/flutter/widgets/Form-class.html
- widget
  - https://codelabs.developers.google.com/flutter-home-screen-widgets
- wear os
  - https://verygood.ventures/blog/building-wear-os-apps-with-flutter-a-very-good-guide
