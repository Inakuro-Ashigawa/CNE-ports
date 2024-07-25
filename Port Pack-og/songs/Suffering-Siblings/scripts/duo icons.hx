/*var pibby:HealthIcon;
var jake:HealthIcon;*/

function postCreate() {/*
  pibby = new HealthIcon("pibby-playable", true);
  pibby.y = healthBar.y - (iconP1.height / 2);
  pibby.x = healthBar.x + (iconP1.width / 2);
  pibby.cameras = [camHUD];
  pibby.health = health;
  insert(members.indexOf(healthBar)+1, pibby);
  
  jake = new HealthIcon("jake", false);
  jakeIcons.y = healthBar.y - (iconP1.height / 2);
  jakeIcons.x = healthBar.x - (iconP1.width / 2);
  jake.cameras = [camHUD];
  jake.health = health;
  insert(members.indexOf(healthBar)+1, jake);*/
  
  
  pibby = new FlxSprite(964, 0).loadGraphic(Paths.image('PA Stuff/pibby'));
  pibby.y = healthBar.y - (iconP1.height / 2);
  pibby.updateHitbox();
  pibby.antialiasing = true;
  pibby.cameras = [camHUD];
  pibby.flipX = true;
  add(pibby);
  insert(members.indexOf(healthBar)+1, pibby);
  
  pibby2 = new FlxSprite(964, 0).loadGraphic(Paths.image('PA Stuff/pibbylose'));
  pibby2.y = healthBar.y - (iconP1.height / 2);
  pibby2.updateHitbox();
  pibby2.antialiasing = true;
  pibby2.cameras = [camHUD];
  pibby2.flipX = true;
  pibby2.alpha = 0.0001;
  add(pibby2);
  insert(members.indexOf(healthBar)+1, pibby2);

  jake = new FlxSprite(163, 0).loadGraphic(Paths.image('PA Stuff/jake'));
  jake.y = healthBar.y - (iconP1.height / 2);
  jake.updateHitbox();
  jake.antialiasing = true;
  jake.cameras = [camHUD];
  add(jake);
  insert(members.indexOf(healthBar)+1, jake);
  
  jake2 = new FlxSprite(163, 0).loadGraphic(Paths.image('PA Stuff/jakelose'));
  jake2.y = healthBar.y - (iconP1.height / 2);
  jake2.updateHitbox();
  jake2.antialiasing = true;
  jake2.cameras = [camHUD];
  jake2.alpha = 0.0001;
  add(jake2);
  insert(members.indexOf(healthBar)+1, jake2);
}
function postUpdate(){
  jake.scale.x = iconP1.scale.x;
  jake.scale.y = iconP1.scale.y;
  
  jake2.scale.x = iconP1.scale.x;
  jake2.scale.y = iconP1.scale.y;

  pibby.scale.x = iconP1.scale.x;
  pibby.scale.y = iconP1.scale.y;
  
  pibby2.scale.x = iconP1.scale.x;
  pibby2.scale.y = iconP1.scale.y;

  if (health > 1.6) {
    jake.alpha = 0.0001;
    jake2.alpha = 1;
    jake2.shader = glitches;
  } else {
    jake.alpha = 1;
    jake2.alpha = 0.0001;
    jake2.shader = null;
  }
if (healthBar.percent < 20){
   if (Options.gameplayShaders) 
     pibby.alpha = 0.0001;
     pibby2.alpha = 1;
     pibby2.shader = glitches;
    } else {
     pibby2.alpha = 0.0001;
     pibby.alpha = 1;
     pibby2.shader = null;
    }

}