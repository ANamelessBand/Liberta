tittles = [
           'Game of Thrones',
           'Pod Igoto',
           'Introduction to Algorithms',
           'Programming in C',
           'Programming in Java',
           'The Healthy Programmer',
           'A Clas of Kings',
           'A Storm of Swords',
           'The Lord of The Rings',
           'The Witching Hour',
           'WarCraft',
          ]

descriptions = ['To keep doing what you love, you need to maintain your own systems, not just the ones you write code for. Regular exercise and proper nutrition help you learn, remember, concentrate, and be creative—skills critical to doing your job well. Learn how to change your work habits, master exercises that make working at a computer more comfortable, and develop a plan to keep fit, healthy, and sharp for years to come.

                This book is intended only as an informative guide for those wishing to know more about health issues. In no way is this book intended to replace, countermand, or conflict with the advice given to you by your own healthcare provider including Physician, Nurse Practitioner, Physician Assistant, Registered Dietician, and other licensed professionals.',
                'Some books on algorithms are rigorous but incomplete; others cover masses of material but lack rigor. Introduction to Algorithms uniquely combines rigor and comprehensiveness. The book covers a broad range of algorithms in depth, yet makes their design and analysis accessible to all levels of readers. Each chapter is relatively self-contained and can be used as a unit of study. The algorithms are described in English and in a pseudocode designed to be readable by anyone who has done a little programming. The explanations have been kept elementary without sacrificing depth of coverage or mathematical rigor.

                The first edition became a widely used text in universities worldwide as well as the standard reference for professionals. The second edition featured new chapters on the role of algorithms, probabilistic analysis and randomized algorithms, and linear programming. The third edition has been revised and updated throughout. It includes two completely new chapters, on van Emde Boas trees and multithreaded algorithms, and substantial additions to the chapter on recurrences (now called "Divide-and-Conquer"). It features improved treatment of dynamic programming and greedy algorithms and a new notion of edge-based flow in the material on flow networks. Many new exercises and problems have been added for this edition.

                As of the third edition, this textbook is published exclusively by the MIT Press.',
                'The first volume of A Song of Ice and Fire, the greatest fantasy epic of the modern age. GAME OF THRONES is now a major TV series from HBO, starring Sean Bean.

                Summers span decades. Winter can last a lifetime. And the struggle for the Iron Throne has begun.

                As Warden of the north, Lord Eddard Stark counts it a curse when King Robert bestows on him the office of the Hand. His honour weighs him down at court where a true man does what he will, not what he must … and a dead enemy is a thing of beauty.

                The old gods have no power in the south, Stark’s family is split and there is treachery at court. Worse, the vengeance-mad heir of the deposed Dragon King has grown to maturity in exile in the Free Cities. He claims the Iron Throne.',
              ]

formats = Format.all
publishers = Publisher.all
tags = Tag.all
authors = Author.all

tittles.each_with_index do |tittle, index|
  dummy_print = Print.new pages: index * 100,
                          price: index * 7.55,
                          date_added: Date.today - (1..200).to_a.sample,
                          tittle: tittle,
                          language: ['english', 'bulgarian'].sample,
                          isbn: 10000 + index,
                          description: descriptions.sample,
                          is_loanable: [true, false].sample,
                          publisher: publishers[index.remainder publishers.count],
                          format: formats[index.remainder formats.count]
  dummy_print.save if dummy_print.valid?
  dummy_print.add_tag tags.sample
  dummy_print.add_author authors.sample
end
