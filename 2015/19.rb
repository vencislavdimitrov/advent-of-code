input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n\n")
rep, molecule = input
rep = rep.split("\n").map { _1.split(' => ') }

variants = []

rep.each do |r|
  ind = molecule.enum_for(:scan, /#{r[0]}/).map { Regexp.last_match.begin(0) }
  ind.each do |i|
    new_molecule = molecule.clone
    new_molecule[i, r[0].size] = r[1]
    variants << new_molecule
  end
end

p variants.uniq.count


molecules = [molecule]

300.times do |t|
  new_molecules = []
  molecules.each do |m|
    rep.each do |r|
      ind = m.enum_for(:scan, /#{r[1]}/).map { Regexp.last_match.begin(0) }
      ind.each do |i|
        new_molecule = m.clone
        new_molecule[i, r[1].size] = r[0]
        if new_molecule == 'e'
          p t + 1
          return
        end
        new_molecules << new_molecule
      end
    end
  end
  molecules = new_molecules.uniq.sort_by(&:size).first(10)
end
