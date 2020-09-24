using Microsoft.EntityFrameworkCore.Migrations;

namespace Manistra.API.Migrations
{
    public partial class Favorites : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "PastaUser",
                columns: table => new
                {
                    FavoritedById = table.Column<string>(type: "text", nullable: false),
                    FavoritesId = table.Column<long>(type: "bigint", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PastaUser", x => new { x.FavoritedById, x.FavoritesId });
                    table.ForeignKey(
                        name: "FK_PastaUser_AspNetUsers_FavoritedById",
                        column: x => x.FavoritedById,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_PastaUser_Pastas_FavoritesId",
                        column: x => x.FavoritesId,
                        principalTable: "Pastas",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_PastaUser_FavoritesId",
                table: "PastaUser",
                column: "FavoritesId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "PastaUser");
        }
    }
}
