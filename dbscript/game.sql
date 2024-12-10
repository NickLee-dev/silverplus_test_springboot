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



-- card ���̺�
create table card (
    id number constraint pk_card_id primary key,  -- ī�� ���� ID
    month number not null,  -- ī���� ��
    type varchar2(20) not null,  -- ī�� Ÿ��
    point number not null, -- ī�� ����
    is_special boolean not null -- Ư�� ī��
);

comment on column card.id is 'ī�����ID';
comment on column card.month is 'ī���� ��';
comment on column card.type is 'ī�� Ÿ��';
comment on column card.point is 'ī�� ����';
comment on column card.is_special is 'Ư��ī�忩��';


-- player ���̺�
create table player(
    id number primary key, -- �÷��̾�id
    name varchar2(100) not null, -- �÷��̾� �̸�
    score number not null, -- ��������
    hand_cards 
    
);
