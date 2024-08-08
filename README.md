# Microserviço de Autenticação

O Microserviço de Autenticação é um componente essencial que gerencia a autenticação de usuários em um sistema distribuído. Ele usa JWT para autenticação segura, interage com um banco de dados PostgreSQL para persistência de dados e comunica-se com outros serviços via gRPC para notificações.

## Funcionalidades

- **Autenticação de Usuário**: Autentica usuários utilizando JWT.
- **Gerenciamento de Usuários**: Criação e validação de usuários.
- **Gerenciamento de Tarefas**: Criação e validação de tarefas.
- **Banco de Dados**: Armazenamento de dados em PostgreSQL.
- **Serviço de Notificação**: Comunicação via gRPC com outros microserviços.

## Arquitetura

Utiliza **Arquitetura Hexagonal (Portas e Adaptadores)** para uma separação clara entre a lógica de negócios e os serviços externos. Adota o padrão de **Pattern Callable** para serviços, promovendo uma estrutura modular e escalável.

## Modelos

### Usuário

#### Validações

- **Nome**: Campo obrigatório.
- **Email**: Obrigatório e único.
- **Senha**: Obrigatória, com no mínimo 5 caracteres.
- **Confirmação de Senha**: Obrigatória e deve corresponder à senha.

#### Mensagens de Erro

- `name`: "não pode ficar em branco"
- `email`: "não pode ficar em branco", "já está em uso"
- `password`: "não pode ficar em branco", "deve ter pelo menos 5 caracteres"
- `password_confirmation`: "não pode ficar em branco", "não confere com a senha"

### Tarefa

#### Validações

- **Título**: Campo obrigatório.
- **Descrição**: Campo obrigatório.

#### Mensagens de Erro

- `title`: "não pode ficar em branco"
- `description`: "não pode ficar em branco"

## Configuração

### Pré-requisitos

- Docker
- Docker Compose

### Comandos

#### Construir Imagem Docker

Para construir a imagem Docker do serviço de autenticação:

```bash
docker build -t my_auth_service .
Iniciar PostgreSQL e Serviço de Autenticação
Inicie o PostgreSQL e o serviço de autenticação com Docker Compose:

bash
Copiar código
docker-compose up
Parar e Remover Contêineres, Redes e Volumes
Para parar e remover todos os contêineres, redes e volumes criados:

bash
Copiar código
docker-compose down
Executar o Serviço de Autenticação
Para rodar o serviço de autenticação localmente:

bash
Copiar código
docker run -d --name auth_service -p 3000:3000 my_auth_service

Comunicação entre Serviços
Serviço de Notificação: Comunicação via gRPC para notificações de tarefas.
Desenvolvimento
Executar Testes
Para executar os testes do serviço de autenticação, certifique-se de ter as dependências instaladas e execute:

bash
Copiar código
rspec
