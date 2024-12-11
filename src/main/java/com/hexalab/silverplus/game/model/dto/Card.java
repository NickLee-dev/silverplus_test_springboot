package com.hexalab.silverplus.game.model.dto;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name="CARD")
@Entity
public class Card {

    @Id
    @Column(name="ID",nullable = false)
    private int id;
    @Column(name="MONTH",nullable = false)
    private int month;
    @Column(name="TYPE", nullable = false, length = 10)
    private String type;
    @Column(name="POINT", nullable = false, columnDefinition = "DEFAULT 0")
    private float point;
    @Column(name="IS_SPECIAL", nullable = false, columnDefinition = "DEFAULT 'N'")
    private String isSpecial;

}
