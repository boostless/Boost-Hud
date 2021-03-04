window.addEventListener('message', function (event) {
    if(event.data.pauseMenu == false){
        $("#statusHud").fadeIn();
        switch (event.data.action) {
            case 'updateStatusHud':
                $("body").css("display", event.data.show ? "block" : "none");
                $("#boxSetHealth").css("width", event.data.health + "%");
                $("#boxSetArmour").css("width", event.data.armour + "%");
    
                widthHeightSplit(event.data.hunger, $("#boxSetHunger"));
                widthHeightSplit(event.data.thirst, $("#boxSetThirst"));
                widthHeightSplit(event.data.oxygen, $("#boxSetOxygen"));
                widthHeightSplit(event.data.stress, $("#boxSetStress"));
                setTalking(event.data.voice);	
        }

    }else{
        $("#statusHud").fadeOut();
    }
});


function widthHeightSplit(value, ele) {
    let height = 25.5;
    let eleHeight = (value / 100) * height;
    let leftOverHeight = height - eleHeight;

    ele.css("height", eleHeight + "px");
    ele.css("top", leftOverHeight + "px");
};

function setTalking(talking){
   if(talking){
    $("#boxSetVoice").css("background", '#ffd769');
    $("#boxSetVoice").css("box-shadow", '0px 0px 28px #ffd769');
   }else{
    $("#boxSetVoice").css("background", '');
    $("#boxSetVoice").css("box-shadow", '0px 0px 18px '); 
   }
};
