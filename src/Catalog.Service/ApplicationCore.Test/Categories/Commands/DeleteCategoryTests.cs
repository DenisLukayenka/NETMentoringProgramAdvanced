using ApplicationCore.Categories.Commands.DeleteCategory;
using ApplicationCore.Common.Exceptions;

namespace ApplicationCore.Test.Categories.Commands;

[TestFixture]
internal class DeleteCategoryTests
{
    private Mock<ICategoryRepository> _repositoryMock;
    private Fixture _fixture;

    [SetUp]
    public void SetUp()
    {
        _repositoryMock = new Mock<ICategoryRepository>();
        _fixture = new Fixture();

        _fixture.Customize<Category>(builder =>
            builder
                .With(c => c.Name, _fixture.Create<string>())
                .With(c => c.Image, _fixture.Create<string>())
                .Without(c => c.ParentCategoryId)
                .Without(c => c.ParentCategory)
                .With(c => c.ChildCategories, []));
    }

    private DeleteCategoryCommandHandler CreateHandler()
        => new(_repositoryMock.Object);

    [Test]
    public async Task Handle_ShouldDeleteCategory_WhenCategoryExistsWithoutDependents()
    {
        // Arrange
        var category = _fixture.Create<Category>();
        var command = new DeleteCategoryCommand(category.Id);

        _repositoryMock
            .Setup(repo => repo.Get(category.Id, It.IsAny<CancellationToken>()))
            .ReturnsAsync(category);

        _repositoryMock
            .Setup(repo => repo.List(category.Id, It.IsAny<CancellationToken>()))
            .ReturnsAsync([]);

        var handler = CreateHandler();

        // Act
        await handler.Handle(command, CancellationToken.None);

        // Assert
        _repositoryMock.Verify(repo => repo.Get(category.Id, It.IsAny<CancellationToken>()), Times.Once);
        _repositoryMock.Verify(repo => repo.List(category.Id, It.IsAny<CancellationToken>()), Times.Once);
        _repositoryMock.Verify(repo => repo.Delete(category, It.IsAny<CancellationToken>()), Times.Once);
    }

    [Test]
    public void Handle_ShouldThrowEntityNotFoundException_WhenCategoryDoesNotExist()
    {
        // Arrange
        var command = new DeleteCategoryCommand(1);

        _repositoryMock
            .Setup(repo => repo.Get(1, It.IsAny<CancellationToken>()))
            .ReturnsAsync((Category)null);

        var handler = CreateHandler();

        // Act & Assert
        FluentActions.Invoking(() => handler.Handle(command, CancellationToken.None))
            .Should().ThrowAsync<EntityNotFoundException>();

        _repositoryMock.Verify(repo => repo.Get(1, It.IsAny<CancellationToken>()), Times.Once);
        _repositoryMock.Verify(repo => repo.Delete(It.IsAny<Category>(), It.IsAny<CancellationToken>()), Times.Never);
    }

    [Test]
    public async Task Handle_ShouldDeleteCategory_WhenCategoryExistsWithDependents()
    {
        // Arrange
        var category = _fixture.Create<Category>();
        var dependents = _fixture.CreateMany<Category>(3).ToArray();
        var command = new DeleteCategoryCommand(category.Id);

        _repositoryMock
            .Setup(repo => repo.Get(category.Id, It.IsAny<CancellationToken>()))
            .ReturnsAsync(category);

        _repositoryMock
            .Setup(repo => repo.List(category.Id, It.IsAny<CancellationToken>()))
            .ReturnsAsync(dependents);

        var handler = CreateHandler();

        // Act
        await handler.Handle(command, CancellationToken.None);

        // Assert
        _repositoryMock.Verify(repo => repo.Get(category.Id, It.IsAny<CancellationToken>()), Times.Once);
        _repositoryMock.Verify(repo => repo.List(category.Id, It.IsAny<CancellationToken>()), Times.Once);
        _repositoryMock.Verify(repo => repo.Delete(category, It.IsAny<CancellationToken>()), Times.Once);
    }
}
