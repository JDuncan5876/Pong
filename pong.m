function pong

global lPos;
global rPos;
global run;
global Hfig;

run = true;
Hfig = figure('KeyPressFcn', @keystrokeExecute,...
              'DeleteFcn', @deletionExecute,...
              'MenuBar', 'none');
          
numbers = makeNumbers;
score = [0 0];

lPos = [20;20];
rPos = [20;770];
ballPos = [295;395];
moveVec = round(rand*18)-9;
moveVec = [moveVec;round(sqrt(144-moveVec^2))];
if rand < 0.5
    moveVec(2) = moveVec(2) * -1;
end

while run
    img = false(600,800);
    img(lPos(1):lPos(1)+29, lPos(2):lPos(2)+9) = true(30,10);
    img(rPos(1):rPos(1)+29, rPos(2):rPos(2)+9) = true(30,10);
    
    if ballPos(1) < 10
        moveVec(1) = abs(moveVec(1));
    elseif ballPos(1) > 580
        moveVec(1) = -abs(moveVec(1));
    elseif all(ballPos > lPos-10) && ballPos(1) < lPos(1) + 30 ...
            && ballPos(2) < lPos(2) + 15
        moveVec = round(rand*18)-9;
        moveVec = [moveVec;round(sqrt(144-moveVec^2))];
    elseif all(ballPos > rPos-15) && ballPos(1) < rPos(1) + 30 ...
            && ballPos(2) < rPos(2) + 10
        moveVec = round(rand*18)-9;
        moveVec = [moveVec;-round(sqrt(144-moveVec^2))];
    elseif ballPos(2) < 10
        ballPos = [295;395];
        moveVec = round(rand*18)-9;
        moveVec = [moveVec;round(sqrt(144-moveVec^2))];
        if rand < 0.5
            moveVec(2) = moveVec(2) * -1;
        end
        score(2) = score(2) + 1;
    elseif ballPos(2) > 790
        ballPos = [295;395];
        moveVec = round(rand*18)-9;
        moveVec = [moveVec;round(sqrt(144-moveVec^2))];
        if rand < 0.5
            moveVec(2) = moveVec(2) * -1;
        end
        score(1) = score(1) + 1;
    end
    
    if all(score < 10)
        img(11:100,231:280) = numbers{score(1)+1};
        img(11:100,521:570) = numbers{score(2)+1};
    end
    
    img(ballPos(1):ballPos(1)+9, ballPos(2):ballPos(2)+9) = true(10,10);
    imshow(img);
    
    ballPos = ballPos + moveVec;
    pause(0.001);
    
    if score(1) == 10
        close all;
        disp('Player 1 wins!');
    elseif score(2) == 10
        close all;
        disp('Player 2 wins!');
    end
end

end

function keystrokeExecute(~,~)

global Hfig;
global lPos;
global rPos;

keystroke = get(Hfig, 'CurrentCharacter');
switch keystroke
    case {'w', 'W'}
        if lPos(1) > 10
            lPos(1) = lPos(1) - 10;
        end
    case {'s', 'S'}
        if lPos(1) < 560
            lPos(1) = lPos(1) + 10;
        end
    case char(30)
        if rPos(1) > 10
            rPos(1) = rPos(1) - 10;
        end
    case char(31)
        if rPos(1) < 560
            rPos(1) = rPos(1) + 10;
        end
end

end

function deletionExecute(~,~)

global run;
run = false;

end

function numbers = makeNumbers

zero = [true(10,50);...
    true(70,10), false(70,30), true(70,10);...
        true(10,50)];
one = [false(90,40), true(90,10)];
two = [true(10,50);...
     false(30,40), true(30,10);...
       true(10,50);...
     true(30,10), false(30,40);...
       true(10,50)];
three = [true(10,50);...
     false(30,40), true(30,10);...
         true(10,50);...
     false(30,40), true(30,10);...
         true(10,50)];
four = [true(40,10), false(40,30), true(40, 10);...
             true(10,50);...
        false(40,40), true(40,10)];
five = [true(10,50);...
   true(30,10), false(30,40);...
        true(10,50);...
   false(30,40), true(30,10);...
        true(10,50)];
six = [true(10,50);...
   true(30,10), false(30,40);...
       true(10,50);...
   true(30,10), false(30,30), true(30,10);...
       true(10,50)];
seven = [true(10,50);...
     false(80,40), true(80,10)];
eight = [true(10,50);...
    true(30,10), false(30,30), true(30,10);...
       true(10,50);...
    true(30,10), false(30,30), true(30,10);...
       true(10,50)];
nine = six(end:-1:1,end:-1:1);

numbers = {zero, one, two, three, four, five, six, seven, eight, nine};

end