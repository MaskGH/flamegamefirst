import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:game_four/main.dart';

class Crow extends SpriteAnimationComponent
    with HasGameRef<CrowGame>, CollisionCallbacks {
  Crow() : super() {
    debugMode = true;
  }

  @override
  void onLoad() async {
    await super.onLoad();
    add(RectangleHitbox.relative(parentSize: size, Vector2(.8, .3)));
    final crowAnimation = await gameRef.loadSpriteAnimation(
        'crow.png',
        SpriteAnimationData.sequenced(
            amount: 11,
            amountPerRow: 11,
            stepTime: 0.1,
            textureSize: Vector2(32, 32)));

    animation = crowAnimation;
    position = gameRef.size / 2;
    anchor = Anchor.center;
    size = Vector2(50, 50);
    add(RectangleHitbox.relative(parentSize: size, Vector2(.8, .3)));
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (y < gameRef.size.y && y > 0) {
      gameRef.gravity.y += .4;
      position += gameRef.gravity * dt;
    } else if (!gameRef.showingGameOverScreen) {
      gameRef.gameOver = true;
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    gameRef.gameOver = true;
    super.onCollisionStart(intersectionPoints, other);
  }
}
