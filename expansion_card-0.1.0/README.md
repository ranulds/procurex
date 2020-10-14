# Expansion Card
![Open Source Love](https://badges.frapsoft.com/os/v2/open-source.svg?v=103)

This package provides an easy implementation of a Expansion type card. You can also add gif or image at the background which expands with the card.


##Screenshot

<p>
    <img src="https://github.com/anirudhsharma392/Expansion-Card/blob/master/screenshots/expansion_card.gif?raw=true"/>

</p>

## How to use

```dart
import 'package:expansion_card/expansion_card.dart';

```

```dart
Center(
            child: ExpansionCard(
              title: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Header",
                    ),
                    Text(
                      "Sub",
                    ),
                  ],
                ),
              ),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 7),
                  child: Text("Content goes over here !",
                ),
                )
              ],
            ));
```

## Custom Usage
There are several options that allow for more control:

|  Properties  |   Description   |
|--------------|--------------|
| `background` |  Provides background image |
| `borderRadius` |  Provides radius to the card |
| `leading` |  Define an action after slidding a button |
| `gif` | (String) address of your gif file ot image file for background|
| `onExpansionChanged` |  When the tile starts expanding, this function is called with the value true. When the tile starts collapsing, this function is called with the value false.|
| `trailing` | A widget to display instead of a rotating arrow icon |
| `initiallyExpanded` | Specifies if the list tile is initially expanded (true) or collapsed (false, the default) |

<br>
<br>

**You can [go here](https://github.com/anirudhsharma392/Expansion-Card/blob/master/example/main.dart) for the example**


# 👍 Contribution
1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -m 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request
