import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame with TapDetector {
  late SpriteComponent cinamoroll;
  late SpriteComponent rock;
  Vector2 velocity = Vector2(0, 100);
  double gravity = 5.0;
  String horizontalDirection = "stop";
  double pushVelocity = 200.0;
  double groundFriction = 50.0;
  double jumpVelocity = -100.0;

  bool isJumping = false;

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    await super.onLoad();

    cinamoroll = SpriteComponent()
      ..sprite = await loadSprite('dog.webp')
      ..size = Vector2(360 * .3, 450 * .3)
      ..position = Vector2(200, 0);
    add(cinamoroll);

    rock = SpriteComponent()
      ..sprite = await loadSprite('rock.png')
      ..size = Vector2(40, 40)
      ..position = Vector2(600, size[1] - 40);
    add(rock);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    if (cinamoroll.position.y < size[1] - cinamoroll.height) {
        velocity.y = velocity.y + gravity;
      
    } else {
      if (isJumping && jumpVelocity < 0) {
        print('he is jumping');
        velocity.y = velocity.y + jumpVelocity;
        jumpVelocity += gravity;
      } else {
        velocity.y = 0;
        isJumping = false;
      }
    }
    cinamoroll.position.add(velocity * dt);

    if (cinamoroll.position.x < size[0] - cinamoroll.width) {
      if (horizontalDirection == "right") {
        if (velocity.x > 0) {
          velocity.x = velocity.x - dt * groundFriction;
        }
      }
    } else {
      velocity.x = 0;
    }

    if (cinamoroll.position.x > 0) {
      if (horizontalDirection == "left") {
        if (velocity.x < 0) {
          velocity.x = velocity.x + dt * groundFriction;
        }
      }
    } else {
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
      velocity.x = -1 * pushVelocity;
    } else if (info.eventPosition.game.x > size[0] - 200) {
      horizontalDirection = "right";
      velocity.x = pushVelocity;
      print("tapped right");
    } else if (info.eventPosition.game.y < 200) {
      isJumping = true;
      jumpVelocity = -100;
      print("go up!");
    }
  }
}
