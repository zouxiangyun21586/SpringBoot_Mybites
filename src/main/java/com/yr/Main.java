package com.yr;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages="com.yr")
@MapperScan("com.yr.mapper")
public class Main {

	public static void main(String[] args) {
		SpringApplication.run(Main.class, args);
	}
}
