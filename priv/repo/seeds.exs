# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AppApi.Repo.insert!(%AppApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias AppApi.Tags

Tags.create_tag(%{text: "note", id_person: nil})
Tags.create_tag(%{text: "task", id_person: nil})
