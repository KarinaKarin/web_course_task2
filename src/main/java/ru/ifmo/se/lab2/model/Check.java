package ru.ifmo.se.lab2.model;

import java.io.Serializable;
import java.util.Objects;

public class Check implements Serializable {
    private Double x;
    private Double y;
    private Double r;
    private Boolean result;

    public Check() {
    }

    public Double getX() {
        return x;
    }

    public void setX(Double x) {
        this.x = x;
    }

    public Double getY() {
        return y;
    }

    public void setY(Double y) {
        this.y = y;
    }

    public Double getR() {
        return r;
    }

    public void setR(Double r) {
        this.r = r;
    }

    public Boolean getResult() {
        return result;
    }

    public void setResult(Boolean result) {
        this.result = result;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Check checkBean = (Check) o;
        return Objects.equals(x, checkBean.x) &&
                Objects.equals(y, checkBean.y) &&
                Objects.equals(r, checkBean.r) &&
                Objects.equals(result, checkBean.result);
    }

    @Override
    public int hashCode() {
        return Objects.hash(x, y, r, result);
    }

    @Override
    public String toString() {
        return "Check{" +
                "x=" + x +
                ", y=" + y +
                ", r=" + r +
                ", result=" + result +
                '}';
    }
}
