Microserviço de Autenticação
Visão Geral
O Microserviço de Autenticação é um componente de um sistema maior, responsável pelo gerenciamento da autenticação de usuários. Este serviço fornece autenticação baseada em JWT e gerencia a criação, validação e gerenciamento de senhas dos usuários. Ele se comunica com um banco de dados PostgreSQL para armazenamento persistente e usa gRPC para comunicação entre serviços com um microserviço de notificação.

Funcionalidades
Autenticação de Usuário: Utiliza JWT para autenticação segura.
Gerenciamento de Usuários: Gerencia a criação e validação de usuários.
Gerenciamento de Tarefas: Gerencia a criação e validação de tarefas.
Banco de Dados: Armazena dados no PostgreSQL.
Serviço de Notificação: Notifica outros serviços via gRPC.
Arquitetura
O serviço utiliza Arquitetura Hexagonal (Portas e Adaptadores) para garantir uma separação limpa entre a lógica de negócios central e as preocupações externas. A lógica central é cercada por adaptadores para o banco de dados, a web e os serviços de notificação.

Modelos
Usuário
Validações
Nome: Campo obrigatório.
Email: Obrigatório e único.
Senha: Obrigatória, com no mínimo 5 caracteres.
Confirmação de Senha: Obrigatória e deve corresponder à senha.
Mensagens de Erro
name: "não pode ficar em branco"
email: "não pode ficar em branco", "já está em uso"
password: "não pode ficar em branco", "deve ter pelo menos 5 caracteres"
password_confirmation: "não pode ficar em branco", "não confere com a senha"
Tarefa
Validações
Título: Campo obrigatório.
Descrição: Campo obrigatório.
Mensagens de Erro
title: "não pode ficar em branco"
description: "não pode ficar em branco"
Configuração
Pré-requisitos
Docker
Docker Compose
1. Construir Imagem Docker
Construa a imagem Docker para o serviço de autenticação:

bash
Copiar código
docker build -t my_auth_service .
2. Iniciar PostgreSQL e Serviço de Autenticação
Inicie o PostgreSQL e o serviço de autenticação usando o Docker Compose:

bash
Copiar código
docker-compose up
