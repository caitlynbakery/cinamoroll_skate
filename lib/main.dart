import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame with TapDetector {
  late SpriteComponent cinamoroll;
  Vector2 velocity = Vector2(0, 100);
  double gravity = 5.0;
  String horizontalDirection = "stop";

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    await super.onLoad();

    cinamoroll = SpriteComponent()
      ..sprite = await loadSprite('dog.webp')
      ..size = Vector2(360 * .3, 450 * .3)
      ..position = Vector2(200, 0);
    add(cinamoroll);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    if (cinamoroll.position.y < size[1] - cinamoroll.height) {
      velocity.y = velocity.y + gravity;
    } else {
      velocity.y = 0;
    }
    cinamoroll.position.add(velocity * dt);

  if(cinamoroll.position.x < size[0] - cinamoroll.width){
    if (horizontalDirection == "right") {
      velocity.x = velocity.x - dt * 10;
    }
  } else {
    velocity.x = 0;
  }
    
     if(cinamoroll.position.x > 0){
 if (horizontalDirection == "left") {
      velocity.x = velocity.x - dt * 10;
    }
  } else{
    velocity.x = 0;
  }
   
  }

  @override
  void onTapUp(TapUpInfo info) {
    // TODO: implement onTapUp
    super.onTapUp(info);
    if (info.eventPosition.game.x < 200) {
      print("tapped left");
      horizontalDirection = "left";
      velocity.x = -100;
    } else if (info.eventPosition.game.x > size[0] - 200) {
      horizontalDirection = "right";
      velocity.x = 100;
      print("tapped right");
    }
    print(info.eventPosition.game.x);
  }
}
