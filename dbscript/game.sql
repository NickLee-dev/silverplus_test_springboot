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


drop table card cascade constraints;
drop table player cascade constraints;



-- card 테이블
create table card (
    id number constraint pk_card_id primary key,  -- 카드 고유 ID
    month number not null,  -- 카드의 월
    type varchar2(20) not null,  -- 카드 타입
    point number not null, -- 카드 점수
    is_special boolean not null -- 특수 카드
);

comment on column card.id is '카드고유ID';
comment on column card.month is '카드의 월';
comment on column card.type is '카드 타입';
comment on column card.point is '카드 점수';
comment on column card.is_special is '특수카드여부';


-- player 테이블
create table player(
    id number primary key, -- 플레이어id
    name varchar2(100) not null, -- 플레이어 이름
    score number not null, -- 현재점수
    hand_cards 
    
);
