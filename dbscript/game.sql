create table game_state (
    id number primary key,
    game_id number not null,
    card_id number not null,
    constraint fk_game foreign key (game_id) references game_state(id)
);

create table deck_cards(
    id number primary key,
    game_id number not null,
    card_id number not null,
    constraint fk_game foreign key (game_id) references game_state(id)
);


-- card Å×ÀÌºí
create table card (
    id number constraint pk_card_id primary key,
    month 
);