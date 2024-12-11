-- ���� ���̺� ���� �� ��� ����
DROP TABLE score_log CASCADE CONSTRAINTS;
DROP TABLE deck_cards CASCADE CONSTRAINTS;
DROP TABLE field_cards CASCADE CONSTRAINTS;
DROP TABLE player_cards CASCADE CONSTRAINTS;
DROP TABLE player CASCADE CONSTRAINTS;
DROP TABLE card CASCADE CONSTRAINTS;
DROP TABLE game_state CASCADE CONSTRAINTS;

------------------------------------------
-- ī�� ���̺�: ���� ���ӿ� ���Ǵ� ��� ī�� ����
------------------------------------------
CREATE TABLE card (
    id NUMBER PRIMARY KEY,
    month NUMBER(2) NOT NULL,               -- ī�尡 ���� �� (1 ~ 12)
    type VARCHAR2(30 BYTE) NOT NULL,        -- ī�� Ÿ�� (��, ��, ��, ���� ��) �ѱ� 3����Ʈ ���
    point NUMBER(5, 2) DEFAULT 0,           -- ī�� ����
    is_special CHAR(1) DEFAULT 'N' CHECK (is_special IN ('Y', 'N')) -- Ư�� ī�� ����
);

COMMENT ON TABLE card IS '���鿡 ���Ǵ� ī�� ������ �����ϴ� ���̺�';
COMMENT ON COLUMN card.id IS 'ī�� ���� ID';
COMMENT ON COLUMN card.month IS 'ī�尡 ���� ��(1~12)';
COMMENT ON COLUMN card.type IS 'ī�� Ÿ��(��, ��, �� ��)';
COMMENT ON COLUMN card.point IS 'ī�� ���� ��';
COMMENT ON COLUMN card.is_special IS 'Ư�� ī�� ���� (Y/N)';


------------------------------------------
-- �÷��̾� ���̺�: ���� �������� ����(�̸�, ����, �� ����, ����) ����
------------------------------------------
CREATE TABLE player (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(150 BYTE) NOT NULL,       -- �÷��̾� �̸� (�ѱ� 3����Ʈ ���, �� 50��)
    score NUMBER DEFAULT 0,                 -- �÷��̾� ����
    is_turn CHAR(1) DEFAULT 'N' CHECK (is_turn IN ('Y', 'N')),         -- ���� �� ����
    player_type VARCHAR2(30 BYTE) DEFAULT 'HUMAN' CHECK (player_type IN ('HUMAN','AI')) -- �÷��̾� ����(HUMAN/AI), ���� ����
);

COMMENT ON TABLE player IS '�÷��̾� ������ �����ϴ� ���̺�(�̸�, ����, �� ����, ����)';
COMMENT ON COLUMN player.id IS '�÷��̾� ���� ID';
COMMENT ON COLUMN player.name IS '�÷��̾� �̸�';
COMMENT ON COLUMN player.score IS '�÷��̾� ����';
COMMENT ON COLUMN player.is_turn IS '���� �� ����(Y/N)';
COMMENT ON COLUMN player.player_type IS '�÷��̾� ����(HUMAN/AI)';


------------------------------------------
-- �÷��̾� ī�� ���̺�: �÷��̾ ���г� ȹ���� ī�� ���� ����
------------------------------------------
CREATE TABLE player_cards (
    id NUMBER PRIMARY KEY,
    player_id NUMBER NOT NULL,
    card_id NUMBER NOT NULL,
    type VARCHAR2(30 BYTE) NOT NULL,  -- ī�� ����(HAND �Ǵ� COLLECTED), ���� ����
    CONSTRAINT fk_player FOREIGN KEY (player_id) REFERENCES player(id),
    CONSTRAINT fk_card FOREIGN KEY (card_id) REFERENCES card(id)
);

COMMENT ON TABLE player_cards IS '�÷��̾ ������ �ִ� ī��(����/ȹ��ī��)�� �����ϴ� ���̺�';
COMMENT ON COLUMN player_cards.id IS '�÷��̾�-ī�� ���� ���� ID';
COMMENT ON COLUMN player_cards.player_id IS '�÷��̾� ID(�ܷ�Ű)';
COMMENT ON COLUMN player_cards.card_id IS 'ī�� ID(�ܷ�Ű)';
COMMENT ON COLUMN player_cards.type IS 'ī�� ����(HAND �Ǵ� COLLECTED)';


------------------------------------------
-- ���� ���� ���̺�: ���� ���� ��Ȳ(�� ����, ���� ����) ����
------------------------------------------
CREATE TABLE game_state (
    id NUMBER PRIMARY KEY,
    turn_order NUMBER(1) DEFAULT 1,  -- ���� �� ���� (1: HUMAN, 2: AI)
    is_finished CHAR(1) DEFAULT 'N' CHECK (is_finished IN ('Y', 'N')) -- ���� ���� ����
);

COMMENT ON TABLE game_state IS '���� ������ ���� ��Ȳ(�� ����, ���� ���� ��)�� �����ϴ� ���̺�';
COMMENT ON COLUMN game_state.id IS '���� ���� ���� ID';
COMMENT ON COLUMN game_state.turn_order IS '���� �� ����(1: HUMAN, 2: AI)';
COMMENT ON COLUMN game_state.is_finished IS '���� ���� ����(Y/N)';


------------------------------------------
-- �ʵ� ī�� ���̺�: ���� �ʵ� ���� ���� ī�� ��� ����
------------------------------------------
CREATE TABLE field_cards (
    id NUMBER PRIMARY KEY,
    game_id NUMBER NOT NULL,
    card_id NUMBER NOT NULL,
    CONSTRAINT fk_game_field FOREIGN KEY (game_id) REFERENCES game_state(id),
    CONSTRAINT fk_card_field FOREIGN KEY (card_id) REFERENCES card(id)
);

COMMENT ON TABLE field_cards IS '���� �ʵ� ���� ���� ī����� �����ϴ� ���̺�';
COMMENT ON COLUMN field_cards.id IS '�ʵ� ī�� ���� ID';
COMMENT ON COLUMN field_cards.game_id IS '���� ���� ID(�ܷ�Ű)';
COMMENT ON COLUMN field_cards.card_id IS 'ī�� ID(�ܷ�Ű)';


------------------------------------------
-- �� ī�� ���̺�: ��(�л�)�� �����ִ� ī�� ���� ����
------------------------------------------
CREATE TABLE deck_cards (
    id NUMBER PRIMARY KEY,
    game_id NUMBER NOT NULL,
    card_id NUMBER NOT NULL,
    CONSTRAINT fk_game_deck FOREIGN KEY (game_id) REFERENCES game_state(id),
    CONSTRAINT fk_card_deck FOREIGN KEY (card_id) REFERENCES card(id)
);

COMMENT ON TABLE deck_cards IS '���� ������ ���� ��(�л�) ī�带 �����ϴ� ���̺�';
COMMENT ON COLUMN deck_cards.id IS '�� ī�� ���� ID';
COMMENT ON COLUMN deck_cards.game_id IS '���� ���� ID(�ܷ�Ű)';
COMMENT ON COLUMN deck_cards.card_id IS 'ī�� ID(�ܷ�Ű)';


------------------------------------------
-- ���� �α� ���̺�: ���� ��ȭ�� �ൿ �̺�Ʈ ���
------------------------------------------
CREATE TABLE score_log (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    game_id NUMBER NOT NULL,
    player_id NUMBER NOT NULL,
    action VARCHAR2(150 BYTE) NOT NULL, -- �ൿ(ī�� ����, ���� ȹ�� ��), �ѱ� 3����Ʈ ��� �� 50��
    score_change NUMBER DEFAULT 0,
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_game_log FOREIGN KEY (game_id) REFERENCES game_state(id),
    CONSTRAINT fk_player_log FOREIGN KEY (player_id) REFERENCES player(id)
);

COMMENT ON TABLE score_log IS '���� ������ �߻��� ���� ��ȭ, ī�� �׼� ���� �̺�Ʈ�� ����ϴ� ���̺�';
COMMENT ON COLUMN score_log.id IS '���� �α� ���� ID';
COMMENT ON COLUMN score_log.game_id IS '���� ���� ID(�ܷ�Ű)';
COMMENT ON COLUMN score_log.player_id IS '�÷��̾� ID(�ܷ�Ű)';
COMMENT ON COLUMN score_log.action IS '�ൿ(ī�� ����, ���� ȹ�� ��)';
COMMENT ON COLUMN score_log.score_change IS '���� ��ȭ��';
COMMENT ON COLUMN score_log.log_time IS '�α� ��� �ð�';
